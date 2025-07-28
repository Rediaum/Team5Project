package edu.sm.repository;

import edu.sm.dto.Product;
import edu.sm.frame.ProjectRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface ProductRepository extends ProjectRepository<Product, Integer> {
}
