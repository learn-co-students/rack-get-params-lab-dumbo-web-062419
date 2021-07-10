class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    # resp.write "#{req.path}"

    if req.path.match(/items/)
      @@items.each { |item| resp.write "#{item}\n"}

    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    elsif req.path.match(/cart/)
      if @@cart.count == 0
        resp.write "Your cart is empty"
      else
        @@cart.each { |item| resp.write "#{item}\n" }
      end

    elsif req.path.match(/add/)
      add_term = req.params["item"]
      resp.write handle_add(add_term)

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_add(item_to_add)
    if @@items.include?(item_to_add)
      @@cart << item_to_add
      return "added #{item_to_add}"
    else
      return "We don't have that item"
    end
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
