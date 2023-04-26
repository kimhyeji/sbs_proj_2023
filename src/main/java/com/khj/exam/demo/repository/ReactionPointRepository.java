package com.khj.exam.demo.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ReactionPointRepository {
	@Select("""
			SELECT IFNULL(SUM(RP.point), 0) AS s
			FROM reactionPoint AS RP
			WHERE RP.relTypeCode = 'article'
			AND RP.id = #{id}
			AND RP.memberId = #{memberId}
			""")
	public int actorCanMakeReactionPoint(int memberId, String relTypeCode, int id);
}
