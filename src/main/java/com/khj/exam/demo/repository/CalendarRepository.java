package com.khj.exam.demo.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface CalendarRepository {
	@Select("""
			SELECT *
			FROM calendar
			""")
	public List<Map<String, Object>> getCalendarList();
}
