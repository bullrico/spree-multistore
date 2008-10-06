class Store < ActiveRecord::Base
  
  class UndefinedError < StandardError; end
  
  has_many :users  
  has_many :products

  validates_presence_of   :name
  validates_uniqueness_of :host
  
  # From Altered Beast - an empty host field makes it the default store to display
  def host=(value)
    write_attribute :host, value.to_s.downcase
  end
  
  def self.main
    @main ||= find :first, :conditions => {:host => ''}
  end
  
  def self.find_by_host(name)
    return nil if name.nil?
    name.downcase!
    name.strip!
    name.sub! /^www\./, ''
    sites = find :all, :conditions => ['host = ? or host = ?', name, '']
    sites.reject { |s| s.default? }.first || sites.first
  end
  
  def default?
    host.blank?
  end
end
