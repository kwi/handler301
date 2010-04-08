# encoding: utf8

module Handler301

private
  # Automatically add _path if not present
  def handle_301_auto_add_path(path_name)
    path_name =~ /(_path|_url)$/ ? path_name : "#{path_name}_path"
  end

public
  # Handle 301 redirections 
  # Make the redirection if an url match
  # Return true if a redirection has been made
  def handle_301(path)
    return nil if !path
    
    t = path.gsub(/^\//, '').split('?', 2)
    path = t[0]

    if r = Handler301Table[path]
      params = t.size == 2 ? Rack::Utils::parse_query(t[1]) : {}

      redirect_path = nil
      # Standard case, use the simple route name
      if !r.index(' ')
        redirect_path = self.send(handle_301_auto_add_path(r).to_sym, params)
      else # Blank case / Works only with hashes

        r = r.split(' ', 2)
        rhash = r.last
        rhash = "{#{rhash}}" unless rhash =~ /^\{.*\}$/

        # Must do an eval here ?
        hash = eval(rhash) rescue {}

        redirect_path = send(handle_301_auto_add_path(r[0]).to_sym, hash.merge(params))
      end

      if redirect_path
        redirect_to redirect_path
        return true
      end
    end

    # No redirection has been made
    return nil
  end

end