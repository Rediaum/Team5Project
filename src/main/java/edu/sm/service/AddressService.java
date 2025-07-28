package edu.sm.service;

import edu.sm.dto.Address;
import edu.sm.frame.ProjectService;
import edu.sm.repository.AddressRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AddressService implements ProjectService<Address, Integer> {

    final AddressRepository addressRepository;

    @Override
    public void register(Address address) throws Exception {
        addressRepository.insert(address);
    }

    @Override
    public void modify(Address address) throws Exception {
        addressRepository.update(address);
    }

    @Override
    public void remove(Integer integer) throws Exception {
        addressRepository.delete(integer);
    }

    @Override
    public List<Address> get() throws Exception {
        return addressRepository.selectAll();
    }

    @Override
    public Address get(Integer integer) throws Exception {
        return addressRepository.select(integer);
    }
}
