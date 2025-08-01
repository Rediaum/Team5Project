package edu.sm.service;

import edu.sm.dto.Category;
import edu.sm.frame.ProjectService;
import edu.sm.repository.CategoryRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class CategoryService implements ProjectService<Category, Integer> {

    private final CategoryRepository categoryRepository;

    @Override
    public void register(Category category) throws Exception {
        categoryRepository.insert(category);
    }

    @Override
    public void modify(Category category) throws Exception {
        categoryRepository.update(category);
    }

    @Override
    public void remove(Integer categoryId) throws Exception {
        categoryRepository.delete(categoryId);
    }

    @Override
    public List<Category> get() throws Exception {
        return categoryRepository.selectAll();
    }

    @Override
    public Category get(Integer categoryId) throws Exception {
        return categoryRepository.select(categoryId);
    }

    /*
     모든 대분류 카테고리 조회
     @return 대분류 카테고리 목록
     */
    public List<Category> getMainCategories() throws Exception {
//        log.info("대분류 카테고리 목록 조회");
        return categoryRepository.selectMainCategories();
    }

    /*
     특정 대분류의 소분류 카테고리들 조회
     @param parentCategoryId 대분류 카테고리 ID
     @return 소분류 카테고리 목록
     */
    public List<Category> getSubCategories(Integer parentCategoryId) throws Exception {
//        log.info("대분류 {}의 소분류 카테고리 조회", parentCategoryId);
        return categoryRepository.selectSubCategories(parentCategoryId);
    }

    /*
     계층 구조를 포함한 모든 카테고리 조회
      @return 모든 카테고리 목록
     */
    public List<Category> getAllWithHierarchy() throws Exception {
//        log.info("계층 구조 포함 전체 카테고리 조회");
        return categoryRepository.selectAllWithHierarchy();
    }

    /*
     카테고리명으로 조회
     @param categoryName 카테고리명
     @return 해당 카테고리
     */
    public Category getByCategoryName(String categoryName) throws Exception {
//        log.info("카테고리명 '{}' 조회", categoryName);
        return categoryRepository.selectByCategoryName(categoryName);
    }

    /*
     특정 카테고리의 하위 카테고리 개수 조회
     @param categoryId 카테고리 ID
     @return 하위 카테고리 개수
     */
    public int getSubCategoryCount(Integer categoryId) throws Exception {
        return categoryRepository.countSubCategories(categoryId);
    }

    /*
     카테고리가 대분류인지 확인
     @param category 카테고리 객체
     @return 대분류이면 true, 소분류이면 false
     */
    public boolean isMainCategory(Category category) {
        return category.getParentCategoryId() == null;
    }

    /**
     카테고리가 소분류인지 확인
      @param category 카테고리 객체
      @return 소분류이면 true, 대분류이면 false
     */
    public boolean isSubCategory(Category category) {
        return category.getParentCategoryId() != null;
    }
}