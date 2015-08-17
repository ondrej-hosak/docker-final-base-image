#!/usr/bin/env ruby

require 'bundler/setup'
require 'travis'

config = YAML.load(ARGF.gets(nil)).deep_symbolize_keys!
Travis::Database.connect

config[:users].each do |u|
  User.where(name: u[:name]).first_or_create(u).update_attributes(u)
end

config[:repos].each do |r|
  new_r = r.merge(owner: User.where(name: r[:owner_name]).first)
  Repository.where(name: r[:name], url: r[:url]).first_or_create(new_r).update_attributes(new_r)
end

config[:users].each do |u|
  if u.has_key?(:permit_repos)
    u[:permit_repos].each do |r|
      owner_name, repo_name = r[:slug].to_s.split('/', 2)
      owner = User.where(name: owner_name).first
      repo = Repository.find_by_name(repo_name)
      puts owner.permissions.first_or_initialize({user: owner, repository: repo}).update_attributes(r[:permissions])
    end
  end
end

