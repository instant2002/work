package com.hp.common.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

public class AbstractDAO {
	protected Log log = LogFactory.getLog(AbstractDAO.class);

	@Autowired // context-mapper.xml���� �����ߴ� SqlSessionTemplate �� ���� �������踦 �ڵ����� �����ϰ� ��.
	private SqlSessionTemplate sqlSession; // context-mapper.xml�� sqlSession�� ��ü�Ѵ�.

	protected void printQueryId(String queryId) {
		if (log.isDebugEnabled()) {
			log.debug("\t QueryId \t: " + queryId);
		}
	}

	public Object insert(String queryId, Object parms) {
		printQueryId(queryId);
		return sqlSession.insert(queryId, parms);
	}

	public Object update(String queryId, Object parms) {
		printQueryId(queryId);
		return sqlSession.update(queryId, parms);
	}

	public Object delete(String queryId, Object parms) {
		printQueryId(queryId);
		return sqlSession.delete(queryId, parms);
	}

	public Object selectOne(String queryId) {
		printQueryId(queryId);
		return sqlSession.selectOne(queryId);
	}

	public Object selectOne(String queryId, Object parms) {
		printQueryId(queryId);
		return sqlSession.selectOne(queryId, parms);
	}

	@SuppressWarnings("rawtypes")
	public List selectList(String queryId) {
		printQueryId(queryId);
		return sqlSession.selectList(queryId);
	}

	@SuppressWarnings("rawtypes")
	public List selectList(String queryId, Object params) {
		printQueryId(queryId);
		return sqlSession.selectList(queryId, params);
	}
}
