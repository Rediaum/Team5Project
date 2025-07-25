package edu.sm.service;

import edu.sm.dto.Product;
import edu.sm.frame.ProjectService;
import edu.sm.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductService implements ProjectService<Product, Integer> {

    final ProductRepository productRepository;

    @Override
    public void register(Product product) throws Exception {
        productRepository.insert(product);
    }

    @Override
    public void modify(Product product) throws Exception {
        productRepository.update(product);
    }

    @Override
    public void remove(Integer i) throws Exception{
        productRepository.delete(i);
    }

    @Override
    public List<Product> get() throws Exception {
        return productRepository.selectAll();
    }

    @Override
    public Product get(Integer i) throws Exception {
        return productRepository.select(i);
    }
}
