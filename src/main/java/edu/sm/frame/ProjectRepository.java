package edu.sm.frame;

import java.util.List;

public interface ProjectRepository<V, K> {
    // Database에 CRUD 기능 정의
    // INSERT(C), SELECT(R), UPDATE(U), DELETE(D)
    void insert(V v) throws Exception; // 추상 함수 : 기능만 정의하는 것
    void update(V v) throws Exception;
    void delete(K k) throws Exception;
    List<V> selectAll() throws Exception;
    V select(K key) throws Exception;
}
