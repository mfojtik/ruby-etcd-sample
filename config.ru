require 'bundler'
Bundler.require :default

class SampleApp < Sinatra::Base

  helpers do

    def etcd
      Etcd.client(
        host: 'etcd',
        port: '2379'
      )
    end

  end

  get '/' do
    value = etcd.get('/sample/time').value rescue 'n/a'
    "\n\nKey '/sample/time' value is set to '#{value}'\n\n"
  end

  get '/set' do
    current_time = Time.now.to_s
    etcd.set('/sample/time', value: current_time)
    "\n\nThe value of '/sample/time' is '#{current_time}'\n\n"
  end

end

run SampleApp
