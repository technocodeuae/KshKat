// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OrderData.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'status': instance.status,
      'msg': instance.msg,
    };

OrderData _$OrderDataFromJson(Map<String, dynamic> json) => OrderData(
      id: json['id'] as int?,
      user_id: json['user_id'].toString() as String?,
      method: json['method'] as String?,
      totalQty: json['totalQty'] as int?,
      Qty: json['Qty'] as int?,
      // pay_amount: json['pay_amount'].toString() as String?,
      total: json['total'] as int?,
      payment_status: json['payment_status'] as String?,
      payment_status_name: json['payment_status_name'] as String?,
      text_payment: json['text_payment'] as String?,
      order_number: json['order_number'] as String?,
      status_name: json['status_name'] as String?,
      text: json['text'] as String?,
      status: json['status'],
      color: json['color'],
      canEdit: json['canEdit'] as bool?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      timestamp: json['timestamp'] as int?,
      timestamp_update: json['timestamp_update'] as int?,
      curr: json['curr'] == null
          ? null
          : CurrData.fromJson(json['curr'] as Map<String, dynamic>),
    )..pdated_at = json['pdated_at'] as String?;

Map<String, dynamic> _$OrderDataToJson(OrderData instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'method': instance.method,
      'totalQty': instance.totalQty,
      'Qty': instance.Qty,
      // 'pay_amount': instance.pay_amount,
      'total': instance.total,
      'payment_status': instance.payment_status,
      'payment_status_name': instance.payment_status_name,
      'text_payment': instance.text_payment,
      'order_number': instance.order_number,
      'status_name': instance.status_name,
      'text': instance.text,
      'status': instance.status,
      'color': instance.color,
      'canEdit': instance.canEdit,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'pdated_at': instance.pdated_at,
      'timestamp': instance.timestamp,
      'timestamp_update': instance.timestamp_update,
      'curr': instance.curr?.toJson(),
    };

OrdersData _$OrdersDataFromJson(Map<String, dynamic> json) => OrdersData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      delivery_slot_id: json['delivery_slot_id'] as List<dynamic>?,
      delivery_slot_time_id: json['delivery_slot_time_id'] as List<dynamic>?,
      date_order: json['date_order'] as String?,
      validity_date: json['validity_date'] as bool?,
      order_line: (json['order_line'] as List<dynamic>?)
          ?.map((e) => OrderLineData.fromJson(e as Map<String, dynamic>))
          .toList(),
      invoice_status: json['invoice_status'] as String?,
      note: json['note'] as String?,
      amount_total: (json['amount_total'] as num?)?.toDouble(),
      amount_tax: (json['amount_tax'] as num?)?.toDouble(),
      delivery_count: json['delivery_count'] as int?,
      cart_quantity: json['cart_quantity'] as int?,
      amount_delivery: (json['amount_delivery'] as num?)?.toDouble(),
      partner_shipping_id: (json['partner_shipping_id'] as List<dynamic>?)
          ?.map(
              (e) => PartnerShippingIdData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrdersDataToJson(OrdersData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date_order': instance.date_order,
      'validity_date': instance.validity_date,
      'order_line': instance.order_line?.map((e) => e.toJson()).toList(),
      'invoice_status': instance.invoice_status,
      'note': instance.note,
      'amount_total': instance.amount_total,
      'amount_tax': instance.amount_tax,
      'delivery_count': instance.delivery_count,
      'cart_quantity': instance.cart_quantity,
      'amount_delivery': instance.amount_delivery,
      'partner_shipping_id':
          instance.partner_shipping_id?.map((e) => e.toJson()).toList(),
      'delivery_slot_id': instance.delivery_slot_id,
      'delivery_slot_time_id': instance.delivery_slot_time_id,
    };

PartnerShippingIdData _$PartnerShippingIdDataFromJson(
        Map<String, dynamic> json) =>
    PartnerShippingIdData(
      id: json['id'] as int?,
      country_id: json['country_id'] as bool?,
      state_id: json['state_id'] as bool?,
      comment: json['comment'] as String?,
      city: json['city'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      mobile: json['mobile'] as String?,
      name: json['name'] as String?,
      parent_name: json['parent_name'] as String?,
      partner_latitude: (json['partner_latitude'] as num?)?.toDouble(),
      partner_longitude: (json['partner_longitude'] as num?)?.toDouble(),
      partner_map_address: json['partner_map_address'] as String?,
    );

Map<String, dynamic> _$PartnerShippingIdDataToJson(
        PartnerShippingIdData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'country_id': instance.country_id,
      'state_id': instance.state_id,
      'comment': instance.comment,
      'city': instance.city,
      'email': instance.email,
      'phone': instance.phone,
      'mobile': instance.mobile,
      'name': instance.name,
      'parent_name': instance.parent_name,
      'partner_latitude': instance.partner_latitude,
      'partner_longitude': instance.partner_longitude,
      'partner_map_address': instance.partner_map_address,
    };

OrderLineData _$OrderLineDataFromJson(Map<String, dynamic> json) =>
    OrderLineData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price_unit: (json['price_unit'] as num?)?.toDouble(),
      price_subtotal: (json['price_subtotal'] as num?)?.toDouble(),
      price_tax: (json['price_tax'] as num?)?.toDouble(),
      price_total: (json['price_total'] as num?)?.toDouble(),
      name_short: json['name_short'] as String?,
      qty_invoiced: (json['qty_invoiced'] as num?)?.toDouble(),
      product_qty: (json['product_qty'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrderLineDataToJson(OrderLineData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price_unit': instance.price_unit,
      'price_subtotal': instance.price_subtotal,
      'price_tax': instance.price_tax,
      'price_total': instance.price_total,
      'name_short': instance.name_short,
      'qty_invoiced': instance.qty_invoiced,
      'product_qty': instance.product_qty,
    };

CurrData _$CurrDataFromJson(Map<String, dynamic> json) => CurrData(
      name: json['name'] as String?,
      sign: json['sign'] as String?,
    );

Map<String, dynamic> _$CurrDataToJson(CurrData instance) => <String, dynamic>{
      'name': instance.name,
      'sign': instance.sign,
    };
