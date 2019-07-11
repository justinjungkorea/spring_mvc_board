package com.justin.service;

import com.justin.dao.*;
import com.justin.domain.*;
import com.justin.mapper.*;
import org.json.*;
import org.mindrot.jbcrypt.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.multipart.*;

import javax.servlet.http.*;
import javax.swing.*;
import java.io.*;
import java.net.*;
import java.util.*;

@Service
public class SpringUserServiceImpl implements SpringUserService{

    @Autowired
    private UserMapper userMapper;

    @Override
    public String emailcheck(String email) {
        return userMapper.emailcheck(email);
    }

    @Override
    public String nicknamecheck(String nickname) {
        return userMapper.nicknamecheck(nickname);
    }

    @Override
    public int join(MultipartHttpServletRequest request) {
        System.out.println("userService join method!");
        int result = 0;

        String email = request.getParameter("email");
        String pw = request.getParameter("pw");
        String nickname = request.getParameter("nickname");
        MultipartFile image = request.getFile("image");
        String uploadPath = request.getServletContext().getRealPath("/views");
        System.out.println("path : " + uploadPath);
        UUID uid = UUID.randomUUID();
        String filename = image.getOriginalFilename();

        SpringUser user = new SpringUser();
        try {
            if(filename.length()>0){
                filename = uid + "_" + filename;
                String filepath = uploadPath + "/" + filename;
                File file = new File(filepath);
                image.transferTo(file);
            } else {
                filename = "default.jpg";
            }
            user.setImage(filename);
            user.setEmail(email);
            user.setPw(BCrypt.hashpw(pw, BCrypt.gensalt(10)));
            user.setNickname(nickname);
            result = userMapper.join(user);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    @Override
    public SpringUser login(HttpServletRequest request) {
        try {
            request.setCharacterEncoding("utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        String email = request.getParameter("email");
        String pw = request.getParameter("pw");
        SpringUser loginUser = userMapper.login(email);

        if(loginUser != null){
            if(BCrypt.checkpw(pw, loginUser.getPw())){
                loginUser.setPw(null);
            } else {
                loginUser = null;
            }
        }

        return loginUser;
    }

    @Override
    public String address(String loc) {
        String[] ar = loc.split(":");
        String latitude = ar[0];
        String longitude = ar[1];
        String addr = "https://dapi.kakao.com/v2/local/geo/coord2address.json?x="+longitude+"&y="+latitude+"&input_coord=WGS84";
        String address = "";
        StringBuilder sb = new StringBuilder();

        try {
            URL url = new URL(addr);
            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
            if (conn != null) {
                conn.setConnectTimeout(20000);
                conn.setUseCaches(false);
                conn.addRequestProperty("Authorization", "KakaoAK 6c97d1fc79afd70a6b2919e235a4de18");
                if (conn.getResponseCode() == HttpURLConnection.HTTP_OK) {
                    InputStreamReader isr = new InputStreamReader(conn.getInputStream());
                    BufferedReader br = new BufferedReader(isr);
                    while (true) {
                        String line = br.readLine();
                        if (line == null) {
                            break;
                        }
                        sb.append(line);
                    }
                }
            }
        } catch (Exception e){
            System.out.println("API EXCEPTION : "+e.getMessage());
            e.printStackTrace();
        }

        String json = sb.toString();
        JSONObject obj = new JSONObject( json);
        JSONArray documents = obj.getJSONArray("documents");
        if(documents.length() > 0) {
            JSONObject item = documents.getJSONObject(0);
            JSONObject addressObj = item.getJSONObject("address");
            address = addressObj.getString("address_name");
        }

        return address;
    }

    @Override
    public int update(MultipartHttpServletRequest request) {
        int result = 0;

        String email = request.getParameter("email");
        String pw = request.getParameter("pw");
        String nickname = request.getParameter("nickname");
        MultipartFile image = request.getFile("image");
        String uploadPath = request.getServletContext().getRealPath("/userimage");
        UUID uid = UUID.randomUUID();
        String filename = image.getOriginalFilename();

        SpringUser user = new SpringUser();
        try {
            if(filename.length()>0){
                filename = uid + "_" + filename;
                String filepath = uploadPath + "/" + filename;
                File file = new File(filepath);
                image.transferTo(file);
            } else {
                filename = "default.jpg";
            }
            user.setImage(filename);
            user.setEmail(email);
            user.setPw(BCrypt.hashpw(pw, BCrypt.gensalt(10)));
            user.setNickname(nickname);
            result = userMapper.update(user);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    @Override
    public int leave(HttpServletRequest request) {

        int result = 01;
        String pw = request.getParameter("pw");
        HttpSession session = request.getSession();
        SpringUser user = (SpringUser)session.getAttribute("user");
        SpringUser loginUser = userMapper.login(user.getEmail());
        if(loginUser != null){
            if(BCrypt.checkpw(pw,loginUser.getPw())){
                loginUser.setPw(null);
            } else {
                loginUser = null;
            }
        }
        if(loginUser != null){
            result = userMapper.leave(user.getEmail());
        }

        return result;
    }
}
