package com.khj.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.khj.exam.demo.vo.Article;

@Mapper
public interface ArticleRepository {
	public Article getForPrintArticle(@Param("id") int id);
	
	public List<Article> getForPrintArticles(@Param("boardId") int boardId);
	
	public void writeArticle(@Param("memberId") int memberId, @Param("boardId") int boardId, @Param("title") String title, @Param("body") String body);
	
	public void deleteArticle(@Param("id") int id);

	public void modifyArticle(@Param("id") int id, @Param("title") String title, @Param("body") String body);

	public int getLastInsertId();

	public int getArticlesCount(@Param("boardId") int boardId);	
}