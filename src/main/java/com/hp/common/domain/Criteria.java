package com.hp.common.domain;

import java.sql.Date;

public class Criteria {
	private int page; //현재 페이지 번호
    private int perPageNum; //한 페이지당 보여줄 게시글 개수
    private String user_id;
    private String book_group;
    private String sortby;
    private String keyword;
    private String isPayment;
    private String delivery_status;
    private String refund_status;
    private String order_code;
    private String fromDate;
    private String toDate;

	public String getOrder_code() {
		return order_code;
	}

	public void setOrder_code(String order_code) {
		this.order_code = order_code;
	}

	public String getFromDate() {
		return fromDate;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

	public String getToDate() {
		return toDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	public String getRefund_status() {
		return refund_status;
	}

	public void setRefund_status(String refund_status) {
		this.refund_status = refund_status;
	}

	public String getIsPayment() {
		return isPayment;
	}

	public void setIsPayment(String isPayment) {
		this.isPayment = isPayment;
	}

	public String getDelivery_status() {
		return delivery_status;
	}

	public void setDelivery_status(String delivery_status) {
		this.delivery_status = delivery_status;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getPageStart() { //특정 페이지의 게시글 시작 번호, 게시갈 시작 행 번호
        return (this.page-1)*perPageNum;
    }
    
    public Criteria() {
        this.page = 1;
    }
    
    public int getPage() {
        return page;
    }
    public void setPage(int page) { //음수가 되면 1페이지를 나타내게 함
        if(page <= 0) {
            this.page = 1;
        } else {
            this.page = page;
        }
    }
    public int getPerPageNum() {
        return perPageNum;
    }
    public void setPerPageNum(int pageCount) { //페이지당 보여줄 게시글 수가 변하지 않게 설정
    	if(pageCount <= 0) { //개수를 몇 개씩 보여줄지 선택할 수 있게 하는 로직
            this.perPageNum = 10;
        } else {
            this.perPageNum = pageCount;
        }
    	
        int cnt = this.perPageNum;
        if(pageCount != cnt) {
            this.perPageNum = cnt;
        } else {
            this.perPageNum = pageCount;
        }
    }
    
    public String getBook_group() {
		return book_group;
	}

	public void setBook_group(String book_group) {
		this.book_group = book_group;
	}

	public String getSortby() {
		return sortby;
	}

	public void setSortby(String sortby) {
		this.sortby = sortby;
	}
	
	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
}