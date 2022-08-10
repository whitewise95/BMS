package com.bms.admin.order.service;

import com.bms.order.dto.OrderDTO;

import java.util.*;

public interface AdminOrderService {

    public List<OrderDTO> listNewOrder(Map<String, Object> condMap) throws Exception;

    public void modifyDeliveryState(Map<String, String> deliveryMap) throws Exception;

    public Map<String, Object> orderDetail(int orderId) throws Exception;

}
