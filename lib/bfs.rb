class BFS
  attr_accessor :array, :visited, :queue
  def initialize
    q = Friendship.select('MAX(member_id) as m1, MAX(friend_id) as m2').order(nil).first
    array_size = (q.m1 > q.m2 ? q.m1 : q.m2) + 1

    @array = Array.new(array_size){ Array.new(array_size){nil} }
    Friendship.find_each do |f|
      id1, id2 = f.member_id, f.friend_id
      @array[id1][id2] = 1
      @array[id2][id1] = 1
    end

    @visited = Hash.new(false)

    @queue = []
  end

  def expand(node)
    res = []
    array[node].each_with_index{|v,i| res << i if v}
    res
  end

  def bfs(start_node, *end_nodes)
    return false if end_nodes.blank?

    queue.push(start_node)
    visited[start_node] = true

    while queue.present?
      node = queue.shift
      if end_nodes.include? node
        return true
      end

      expand(node).each do |child|
        unless visited[child]
          queue.push(child)
          visited[child] = true
        end
      end
    end
    return false
  end
end
