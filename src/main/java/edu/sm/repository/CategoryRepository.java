package edu.sm.repository;

import edu.sm.dto.Category;
import edu.sm.frame.ProjectRepository;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface CategoryRepository extends ProjectRepository<Category, Integer> {

    /**
     * 모든 대분류 카테고리 조회 (parent_category_id가 null인 것들)
     * @return 대분류 카테고리 목록
     */
    List<Category> selectMainCategories() throws Exception;

    /**
     * 특정 대분류의 소분류 카테고리들 조회
     * @param parentCategoryId 대분류 카테고리 ID
     * @return 해당 대분류의 소분류 목록
     */
    List<Category> selectSubCategories(@Param("parentCategoryId") Integer parentCategoryId) throws Exception;

    /**
     * 계층 구조를 포함한 모든 카테고리 조회
     * @return 모든 카테고리 목록 (대분류 먼저, 소분류는 parent_category_id 순으로)
     */
    List<Category> selectAllWithHierarchy() throws Exception;

    /**
     * 카테고리명으로 조회
     * @param categoryName 카테고리명
     * @return 해당 카테고리
     */
    Category selectByCategoryName(@Param("categoryName") String categoryName) throws Exception;

    /**
     * 특정 카테고리의 하위 카테고리 개수 조회
     * @param categoryId 카테고리 ID
     * @return 하위 카테고리 개수
     */
    int countSubCategories(@Param("categoryId") Integer categoryId) throws Exception;
}