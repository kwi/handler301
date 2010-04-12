# encoding: utf8
module Handler301
  Hash301 = {}

private
  # Automatically add _path if not present
  def handle_301_auto_add_path(path_name)
    path_name =~ /(_path|_url)$/ ? path_name : "#{path_name}_path"
  end

public
  # Handle 301 redirections 
  # Make the redirection if an url match
  # Return true if a redirection has been made
  def handle_301(path, query_params = {})
    return nil if !path
    
    path = path.gsub(/^\//, '').split('?', 2).first

    if r = Hash301[path]
      query_params.delete('action')
      query_params.delete('controller')

      redirect_path = nil
      # Standard case, use the simple route name
      if !r.index(' ')
        redirect_path = self.send(handle_301_auto_add_path(r).to_sym, query_params)
      else # Blank case / Works only with hashes

        r = r.split(' ', 2)
        rhash = r.last
        rhash = "{#{rhash}}" unless rhash =~ /^\{.*\}$/

        # Must do an eval here ?
        hash = eval(rhash) rescue {}

        redirect_path = send(handle_301_auto_add_path(r[0]).to_sym, hash.merge(query_params))
      end

      if redirect_path
        redirect_to(redirect_path, :status => 301)
        return true
      end
    end

    # No redirection has been made
    return nil
  end
  
  def self.load_301_file(file)
    h = YAML.load_file(file) rescue {}
    puts "[Handler301] Error in loading '#{file}', this file is empty or not valid." if h.size == 0
    Hash301.merge!(h)
  end

end

# Load config 301 file
if defined? Rails
  Handler301::load_301_file('config/handler301.yml')
end

# Include 301 handler in ActionController base
ActionController::Base.send :include, Handler301