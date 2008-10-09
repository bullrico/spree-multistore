class Store < ActiveRecord::Base
  
  class UndefinedError < StandardError; end
  
  has_many :users  
  has_many :products
  has_many :taxonomies
  
  validates_presence_of   :name
  
  make_permalink :with => :name, :field => :permalink
  
  def self.default
    @default ||= find :first, :conditions => {:host => ''}
  end
  
  def self.find_by_host(name)
    return nil if name.nil?
    name.downcase!
    name.strip!
    name.sub! /^www\./, ''
    stores = find :all, :conditions => ['host = ? or host = ?', name, '']
    stores.reject { |s| s.default? }.first || stores.first
  end
  
  def default?
    host.blank?
  end
end
