package edu.sm.repository;

import edu.sm.dto.Address;
import edu.sm.frame.ProjectRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface AddressRepository extends ProjectRepository<Address, Integer> {
}