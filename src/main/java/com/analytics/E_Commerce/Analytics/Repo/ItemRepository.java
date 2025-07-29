package com.analytics.E_Commerce.Analytics.Repo;

import com.analytics.E_Commerce.Analytics.Model.Item;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ItemRepository extends JpaRepository<Item, Long> {}