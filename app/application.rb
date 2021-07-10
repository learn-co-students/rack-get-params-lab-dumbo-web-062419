class Application


  @@cart = []
  @@items = ["Apples", "Pears", "Figs"]

def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/cart/)
      
      if @@cart == []
        resp.write "Your cart is empty"
      else
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
       end


      elsif req.path.match(/add/)

        added_item = req.params["item"]
       
      if @@items.include?(added_item)
        @@cart << added_item
        resp.write "added #{added_item}"
      else
        resp.write "We don't have that item"
      end

      
    end

    resp.finish
  end

  # def handle_search(search_term)
  #   if @@items.include?(search_term)
  #     return "#{search_term} is one of our items"
  #   else
  #     return "Couldn't find #{search_term}"
  #   end
  # end
end
