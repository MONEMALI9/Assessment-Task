def getRepeatedNetworkTraffic(packets):
  
    packet_counts = {}

    for packet in packets:
        if packet in packet_counts:
            packet_counts[packet] += 1
        else:
            packet_counts[packet] = 1

    result = []
    for packet_id, count in packet_counts.items():
        result.append(f"id = {packet_id} repeated {count} times")

    return result


# test case
packets = [1, 2, 3, 4, 1, 2, 7, 2, 3, 4]
repeated_traffic = getRepeatedNetworkTraffic(packets)

for item in repeated_traffic:
    print(item)
