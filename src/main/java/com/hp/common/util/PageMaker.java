package com.hp.common.util;

import com.hp.common.domain.Criteria;

public class PageMaker {
	
	private Criteria cri;
	private int page; //현재 페이지
    private int totalCount; //총 게시글 수
    private int startPage; //화면에 보여질 첫번째 페이지 번호, 시작 페이지 번호
    private int endPage; //화면에 보여질 마지막 페이지 번호, 끝페이지 번호
    private boolean prev; //이전 버튼 생성 여부
    private boolean next; //다음 버튼 생성 여부
    private int displayPageNum = 5; //화면 하단에 보여지는 페이지 버튼의 수
    
    public Criteria getCri() {
        return cri;
    }
    public void setCri(Criteria cri) {
        this.cri = cri;
    }
    public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
    public int getTotalCount() {
        return totalCount;
    }
    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        calcData(); //총 게시글 수를 세팅할 때  페이징 관련 버튼을 계산
    }
    
    private void calcData() { //페이징의 버튼들을 생성하는 계산식. 끝 페이지 번호, 시작페이지 번호, 이전, 다음 버튼들을 구함
    	//cri.getPage() = 현재페이지 번호
    	//cri.getPerPageNum() = 한 페이지당 보여줄 게시글의 개수 
        endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
        int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum()));
        if (endPage > tempEndPage) {
            endPage = tempEndPage;
        }
        
        startPage = (endPage - displayPageNum) + 1;
        if(startPage <= 0) startPage = 1; //페이지 번호 개수가 5개 이하인 경우에 에러가 발생해서 이 코드로 방지 
 
        prev = startPage == 1 ? false : true;
        next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
        
    }
    
    public int getStartPage() {
        return startPage;
    }
    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }
    public int getEndPage() {
        return endPage;
    }
    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }
    public boolean isPrev() {
        return prev;
    }
    public void setPrev(boolean prev) {
        this.prev = prev;
    }
    public boolean isNext() {
        return next;
    }
    public void setNext(boolean next) {
        this.next = next;
    }
    public int getDisplayPageNum() {
        return displayPageNum;
    }
    public void setDisplayPageNum(int displayPageNum) {
        this.displayPageNum = displayPageNum;
    }
}
