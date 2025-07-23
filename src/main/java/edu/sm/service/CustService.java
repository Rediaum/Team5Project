package edu.sm.service;

import edu.sm.dto.Cust;
import edu.sm.frame.ProjectService;
import edu.sm.repository.CustRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CustService implements ProjectService<Cust, Integer> {

    final CustRepository custRepository;

    @Override
    public void register(Cust cust) throws Exception {
        custRepository.insert(cust);
    }

    @Override
    public void modify(Cust cust) throws Exception {
        custRepository.update(cust);
    }

    @Override
    public void remove(Integer i) throws Exception {
        custRepository.delete(i);
    }

    @Override
    public List<Cust> get() throws Exception {
        return custRepository.selectAll();
    }

    @Override
    public Cust get(Integer i) throws Exception {
        return custRepository.select(i);
    }
}
