import com.justin.service.*;
import org.apache.ibatis.session.*;
import org.junit.*;
import org.junit.runner.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.test.context.*;
import org.springframework.test.context.junit4.*;
import org.springframework.test.context.web.*;

import javax.sql.*;
import java.sql.*;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:root-context.xml","file:src/main/webapp/WEB-INF/spring-servlet.xml"})
public class BoardTest {

    @Autowired
    private SpringUserService userService;

    @Autowired
    private SpringBoardService boardService;

    @Test
    public void list(){
    }

    @Test
    public void emailcheck(){
        userService.emailcheck("jungdw0624@gmail.com");
    }

    @Test
    public void nicknamecheck(){
        userService.nicknamecheck("justin");
    }

    //테스트 할 객체 주입
    @Autowired
    private DataSource dataSource;

    //테스트 할 메소드
    @Test
    public void conTest() {
        try(Connection con = dataSource.getConnection()){
            System.out.println("con:" + con);
        }catch(Exception e) {
            System.out.println("예외:" +e.getMessage());
        }
    }

    @Autowired
    private SqlSession sqlSession;

    @Test
    public void sqlSessionTest() throws Exception{
        System.out.println(sqlSession);
    }
}
