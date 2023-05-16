package com.khj.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Calendar {
	private int id;
	private String title;
	private String writer;
	private String content;
	private String start;
	private String end;
	private boolean allday;
	private String textColor;
	private String backgroundColor;
	private String borderColor;
}