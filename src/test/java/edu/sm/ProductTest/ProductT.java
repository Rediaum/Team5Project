package edu.sm.ProductTest;

import edu.sm.dto.Product;
import edu.sm.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
@Slf4j
public class ProductT {

    @Autowired
    ProductService productService;

    @Test
    void getall() {
        List<Product> list = null;
        try{
            list = productService.get();
            list.forEach(product -> log.info(product.toString()));
            log.info("Select All End ----------------------");
        } catch (Exception e){
            log.info("Select All Test Error...");
            e.printStackTrace();
        }
    }
}
