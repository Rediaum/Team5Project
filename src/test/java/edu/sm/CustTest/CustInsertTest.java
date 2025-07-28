package edu.sm.CustTest;

import edu.sm.dto.Cust;
import edu.sm.service.CustService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
@Slf4j
public class CustInsertTest {

    @Autowired
    CustService custService;

    @Test
    void insert() {
        Cust cust = Cust.builder().custEmail("test@test.com").custPwd("test").custName("test").custPhone("010-1234-5678").build();
        try {
            custService.register(cust);
            log.info("Insert End ------------------------------------------");
        } catch (Exception e) {
            log.info("Error Insert Test ...");
            e.printStackTrace();
        }
    }
}
