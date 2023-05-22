package com.khj.exam.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.khj.exam.demo.service.CalendarService;
import com.khj.exam.demo.utill.Ut;
import com.khj.exam.demo.vo.Calendar;
import com.khj.exam.demo.vo.ResultData;

@Controller
public class UsrCalendarController {
	public CalendarService calendarService;

	public UsrCalendarController(CalendarService calendarService) {
		this.calendarService = calendarService;
	}

	@RequestMapping("/usr/caln/calendar")
	public String showCalendar(Model model) {
		return "usr/caln/calendar";
	}

	@RequestMapping("/usr/caln/getCalendar")
	@ResponseBody
	public  List<Map<String, Object>> getCalendar() {
		List<Map<String, Object>> calList = calendarService.getCalendarList();

		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArr = new JSONArray();

		HashMap<String, Object> hash = new HashMap<String, Object>();

		for (int i = 0; i < calList.size(); i++) {
			hash.put("id", calList.get(i).get("id"));
			hash.put("title", calList.get(i).get("title"));
			hash.put("writer", calList.get(i).get("writer"));
			hash.put("content", calList.get(i).get("content"));
			hash.put("start", calList.get(i).get("startDate"));
			hash.put("end", calList.get(i).get("endDate"));
			hash.put("allDay", calList.get(i).get("allDay"));
			hash.put("textColor", calList.get(i).get("textColor"));
			hash.put("backgroundColor", calList.get(i).get("backgroundColor"));
			hash.put("borderColor", calList.get(i).get("borderColor"));

			jsonObj = new JSONObject(hash);
			jsonArr.add(jsonObj);
		}

		return jsonArr;
	}

	@RequestMapping("/usr/caln/doDeleteSchedule")
	@ResponseBody
	public ResultData doDeleteSchedule(int id) {
		if (Ut.empty(id)) {
			return ResultData.from("F-1", "id(을)를 입력해주세요.");
		}

		ResultData deleteScheduleRd = calendarService.deleteSchedule(id);

		return ResultData.from("S-1", deleteScheduleRd.getMsg());
	}

}