class Array

  def my_map
    arr = []
    if block_given?
      self.each { |e| arr << yield(e) }
    else
      arr = to_enum :my_map
    end
    arr
  end

  def sort_arr
    sort { |x, y| x <=> y }
  end

end

class DesignHash

  def self.nested_hash_value(obj,key)
    if obj.respond_to?(:key?) && obj.key?(key)
      obj[key]
    elsif obj.respond_to?(:each)
      r = nil
      obj.find{ |*a| r=nested_hash_value(a.last,key) }
      r
    end
  end

  def convert_hash(sample_data)
    user_id = DesignHash.nested_hash_value(sample_data, 'user_id')
    message = (DesignHash.nested_hash_value(sample_data, 'silent') == true) ? "You have #{DesignHash.nested_hash_value(sample_data, 'badge_count')} notifications" : DesignHash.nested_hash_value(sample_data, 'Alert_message')
    message_type = DesignHash.nested_hash_value(sample_data, 'notification_type')
    pop_up = DesignHash.nested_hash_value(sample_data, 'silent')
    publish_at = DesignHash.nested_hash_value(sample_data, 'effective_date')
    device_target = DesignHash.nested_hash_value(sample_data, 'devices').split(" => ")
    target = (device_target == 'ios') ? 'ios' : 'gsm'
    device_id = device_target[1]

    {payload: {user_id: user_id, message: message, message_type: message_type, pop_up: pop_up, publish_at: publish_at, target: target, device_id: device_id}}
  end
end