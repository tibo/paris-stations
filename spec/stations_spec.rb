describe 'test stations endpoint' do
	include Rack::Test::Methods

	it 'call without no argument should return 400 status' do
		get '/stations'
		expect(last_response.status).to eq(400)
	end

	it 'call with invalid location argument should return 400 status' do
		get '/stations?ll=yo'
		expect(last_response.status).to eq(400)
	end

	it 'call with location argument should return 200 status' do
		get '/stations?ll=48.9140418,2.3326823'
		expect(last_response).to be_ok
	end

	it 'call with location argument only should return 10 items' do
		get '/stations?ll=48.9140418,2.3326823'
		expect(last_response).to be_ok

		results = JSON.parse(last_response.body)

		expect(results.length).to eq(10)
	end

	it 'call with n argument should return n items' do
		get '/stations?ll=48.9140418,2.3326823&n=666'
		expect(last_response).to be_ok

		results = JSON.parse(last_response.body)

		expect(results.length).to eq(666)
	end

	it 'call with n=1 argument should return 1 items' do
		get '/stations?ll=48.9140418,2.3326823&n=1'
		expect(last_response).to be_ok

		results = JSON.parse(last_response.body)

		expect(results.length).to eq(1)
	end

	it 'call with metro as types argument should return only metro items' do
		get '/stations?ll=48.9140418,2.3326823&types=metro'
		expect(last_response).to be_ok

		results = JSON.parse(last_response.body)

		results.each do |r|
			expect(r['type']).to eq('metro')
		end
	end

	it 'call with metro and rer as types argument should return only metro or rer items' do
		get '/stations?ll=48.9140418,2.3326823&types=metro,rer&n=100'
		expect(last_response).to be_ok

		results = JSON.parse(last_response.body)

		results.each do |r|
			expect((r['type'].eql? 'metro') || (r['type'].eql? 'rer')).to be true
		end
	end

	it 'call should return the right values' do
		get '/stations?ll=48.9140418,2.3326823&n=1&types=metro'
		expect(last_response).to be_ok

		results = JSON.parse(last_response.body)

		expect(results.length).to eq(1)

		result = results.first

		expect(result['city']).to eq('SAINT-OUEN')
		expect(result['geo_near_distance']).to eq(0.002472258879984481)
		expect(result['name']).to eq('Mairie de Saint-Ouen')
		expect(result['ratp_id']).to eq(1818)
		expect(result['type']).to eq('metro')
		expect(result['latitude']).to eq(48.9120620157054)
		expect(result['longitude']).to eq(2.334163015407)
	end

	it 'call should return the right values' do
		get '/stations?ll=48.888776,2.388756&n=3&types=metro'
		expect(last_response).to be_ok

		results = JSON.parse(last_response.body)

		expect(results.length).to eq(3)

		result = results.first

		expect(result['city']).to eq('PARIS-19EME')
		expect(result['geo_near_distance']).to eq(0.002748591901994253)
		expect(result['name']).to eq('Porte de Pantin')
		expect(result['ratp_id']).to eq(1728)
		expect(result['type']).to eq('metro')
		expect(result['latitude']).to eq(48.8883327364608)
		expect(result['longitude']).to eq(2.39146861403051)
	end

end