package com.analytics.E_Commerce.Analytics.Service;
import com.analytics.E_Commerce.Analytics.Model.Order;
import com.analytics.E_Commerce.Analytics.Repo.OrderRepository;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.util.List;

@Service
public class ImportService {

    private final OrderRepository orderRepository;
    private final ObjectMapper mapper = new ObjectMapper();

    public ImportService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    public void importOrdersFromJson() throws Exception {
        try (InputStream is = getClass().getClassLoader().getResourceAsStream("orders.json")) {
            if (is == null) {
                throw new RuntimeException("orders.json not found in resources");
            }

            List<Order> orders = mapper.readValue(is, new TypeReference<List<Order>>() {});
            for (Order order : orders) {
                // fix relationships
                if (order.getOrderItems() != null) {
                    order.getOrderItems().forEach(item -> item.setOrder(order));
                }
                if (order.getPayments() != null) {
                    order.getPayments().forEach(p -> p.setOrder(order));
                }
            }
            orderRepository.saveAll(orders);
        }
    }
}
