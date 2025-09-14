package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.MembersDTO;

@Repository
public class MembersDAO {

	@Autowired
	private JdbcTemplate jdbc;

	public int insert(MembersDTO dto) throws Exception {

		String sql = "insert into members values (?,?,?,?,?,?,?,?)";
		return jdbc.update(sql, dto.getId(), dto.getPw(), dto.getName(), dto.getPhone(), dto.getEmail(),
				dto.getzipCode(), dto.getAddress1(), dto.getAddress2());
	}

	public boolean checkId(String id) throws Exception {

		String sql = "SELECT id FROM members WHERE id = ?";
		List<MembersDTO> list = jdbc.query(sql, new BeanPropertyRowMapper<>(MembersDTO.class), id);
		return !list.isEmpty();

	}

	public MembersDTO selectUser(MembersDTO dto) throws Exception {
		String sql = "select * from members where id= ? and pw  = ?";
		MembersDTO list = jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(MembersDTO.class), dto.getId(),
				dto.getPw());
		return list;
	}

	public void delete(String id) throws Exception {

		String sql = "delete members where id = ?";
		jdbc.update(sql,id);
		return;
	}
}
