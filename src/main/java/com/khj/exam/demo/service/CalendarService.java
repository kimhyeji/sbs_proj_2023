package com.khj.exam.demo.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.khj.exam.demo.repository.CalendarRepository;
import com.khj.exam.demo.utill.Ut;
import com.khj.exam.demo.vo.ResultData;

@Service
public class CalendarService {
	public CalendarRepository calendarRepository;

	public CalendarService(CalendarRepository calendarRepository) {
		this.calendarRepository = calendarRepository;
	}

	public List<Map<String, Object>> getCalendarList() {
		return calendarRepository.getCalendarList();
	}

	public ResultData deleteEvent(int id) {
		calendarRepository.deleteEvent(id);

		return ResultData.from("S-1", "일정을 삭제하였습니다.");
	}

}
