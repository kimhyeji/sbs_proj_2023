package com.khj.exam.demo.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.khj.exam.demo.repository.CalendarRepository;

@Service
public class CalendarService {
	public CalendarRepository calendarRepository;

	public CalendarService(CalendarRepository calendarRepository) {
		this.calendarRepository = calendarRepository;
	}
	
	public List<Map<String, Object>> getCalendarList() {
		return calendarRepository.getCalendarList();
    }

}
