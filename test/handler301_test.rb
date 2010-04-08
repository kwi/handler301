require 'test_helper'

class Handler301ControllerTest < ActionController::TestCase

  def setup
    ActionController::Routing::Routes.draw do |map|
      map.resource :handler301, :controller => :handler301
      map.resource :home, :controller => :home
      map.resources :products
    end
  end

  def test_non_matching_url
    get 'show'
    assert_equal @response.body, 'KO'
  end
  
  def test_non_matching_url_again
    get 'show', :path => 'non_matching_url'
    assert_equal @response.body, 'KO'
  end
  
  def test_non_matching_url_again_with_params
    get 'show', :path => 'non_matching_url?hi=42'
    assert_equal @response.body, 'KO'
  end
  
  def test_matching_url_simple_route
    get 'show', :path => "old_url.html"
    assert_redirected_to home_path
  end

  def test_matching_url_simple_route_with_trailing_slash
    get 'show', :path => "/old_url.html"
    assert_redirected_to home_path
  end
  
  def test_matching_url_simple_route_without_underscore_path
    get 'show', :path => "/old_url_without_path.html"
    assert_redirected_to home_path
  end
  
  def test_matching_url_simple_route_with_params
    get 'show', :path => "old_url.html?params1=2&params2=44"
    assert_redirected_to home_path(:params1 => 2, :params2 => 44)
  end
  
  def test_matching_url_with_blank_in_route
    get 'show', :path => "product_number_one.html?params1=2&params2=44"
    assert_redirected_to products_path(:params1 => 2, :params2 => 44, :id => 1)
  end
  
  def test_matching_url_with_blank_in_route_with_params
    get 'show', :path => "product_number_one.html?params1=2&params2=44"
    assert_redirected_to products_path(:params1 => 2, :params2 => 44, :id => 1)
  end

end
