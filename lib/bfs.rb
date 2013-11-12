class BFS
  attr_accessor :array, :visited, :queue, :p, :result
  def initialize
    q = Friendship.select('MAX(member_id) as m1, MAX(friend_id) as m2, MAX(id) as m3').order(nil).first
    rows_count = (q.m1 > q.m2 ? q.m1 : q.m2) + 1
    columns_count = q.m3 + 1

    @array = Array.new(rows_count){ Array.new(rows_count){0} }
    Friendship.find_each do |f|
      id1, id2 = f.member_id, f.friend_id
      @array[id1][id2] = 1
      @array[id2][id1] = 1
    end
    
    # @array = Array.new(rows_count){ Array.new(columns_count){0} }
    # Friendship.find_each do |f|
    #   id1, id2 = f.member_id, f.friend_id
    #   @array[id1][f.id] = 1
    #   @array[id2][f.id] = 1
    # end

    @visited = Hash.new(false)

    @queue = []
    @p = Hash.new
    @result = []
  end

  def bfs(start_node, *end_nodes)
    return false if end_nodes.blank?

    queue.push(start_node)
    visited[start_node] = true
    current_path = [start_node]

    p[start_node] = nil

    while queue.present?
      node = queue.shift

      if end_nodes.include? node
        result << path(start_node, node)
      end

      array[node].each_with_index do |v,child|
        next unless v == 1
        unless visited[child]
          queue.push(child)
          visited[child] = true
          @p[child] = node
        end
      end
    end
    return result
  end

  def path(s, v)
    res = []
    while true
      break if v.nil?
      res << v
      v = p[v]
    end
    res.reverse
  end
end
