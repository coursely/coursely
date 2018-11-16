RSpec.shared_examples "an unauthorized mutation" do |mutation|
  context "with a current user" do
    let(:current_user) { FactoryBot.build :user }
    let(:context) { { current_user: current_user } }

    it { is_expected.to match({
      "data" => {
        mutation => nil
      },
      "errors" => [{
        "message" => "You are already signed in",
        "locations" => [{
          "line" => 2,
          "column" => 3
        }],
        "path" => [mutation]
      }]
    })}
  end

  context "without a current user" do
    let(:context) { { current_user: nil } }

    it { is_expected.not_to match "data" => {
      mutation => nil
    } }
  end
end
