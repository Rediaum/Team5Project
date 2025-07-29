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

    /**
     * 특정 고객의 모든 배송지 조회
     * @param custId 고객 ID
     * @return 해당 고객의 배송지 목록
     */
    public List<Address> getAddressByCustomerId(Integer custId) throws Exception {
        return addressRepository.selectByCustomerId(custId);
    }

    /**
     * 특정 고객의 기본 배송지 조회
     * @param custId 고객 ID
     * @return 기본 배송지 (없으면 null)
     */
    public Address getDefaultAddress(Integer custId) throws Exception {
        return addressRepository.selectDefaultByCustomerId(custId);
    }

    /**
     * 특정 고객의 모든 배송지를 기본 배송지가 아닌 상태로 변경
     * @param custId 고객 ID
     */
    public void resetDefaultAddress(Integer custId) throws Exception {
        addressRepository.resetDefaultByCustomerId(custId);
    }

    /**
     * 특정 고객의 배송지 개수 조회
     * @param custId 고객 ID
     * @return 배송지 개수
     */
    public int getAddressCount(Integer custId) throws Exception {
        return addressRepository.countByCustomerId(custId);
    }
}