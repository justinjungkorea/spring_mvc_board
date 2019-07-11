package com.justin.domain;

public class Criteria {

    private int page;
    private int perPageNum;
    private int pageStart;

    public Criteria() {
        this.page = 1;
        this.perPageNum = 10;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getPerPageNum() {
        return perPageNum;
    }

    public void setPerPageNum(int perPageNum) {
        this.perPageNum = perPageNum;
    }

    public int getPageStart() {
        pageStart = (page-1)*perPageNum + 1;
        return pageStart;
    }

    public void setPageStart(int pageStart) {
        this.pageStart = pageStart;
    }

    @Override
    public String toString() {
        return "Criteria{ page=" + page + ", perPageNum=" + perPageNum + ", pageStart=" + pageStart + '}';
    }
}
