package com.two.crm.model.dao;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.two.crm.dto.UserDto;

@Repository
public class Users_DaoImpl implements Users_IDao{
	
	
	private final String NS = "com.two.crm.model.dao.Users_DaoImpl.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<UserDto> AllUsers() {
		return sqlSession.selectList(NS+"AllUsers");
	}

	


}