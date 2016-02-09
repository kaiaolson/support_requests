require 'rails_helper'

RSpec.describe SupportRequestsController, type: :controller do

  let(:support_request) {FactoryGirl.create(:support_request) }

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
    it "instantiates a new SupportRequest object and sets it to @support_request" do
      get :new
      expect(assigns(:support_request)).to be_a_new(SupportRequest)
    end
  end

  describe "#create" do
    context "with valid attributes" do
      def valid_request
        post :create, support_request: {name: "testing valid name",
                                        email: "test@test.com",
                                        department: "sales",
                                        message: "some valid message",
                                        completed: "not done"}
      end
      it "creates a new record in the database" do
        support_request_count_before = SupportRequest.count
        valid_request
        support_request_count_after = SupportRequest.count
        expect(support_request_count_after - support_request_count_before).to eq(1)
      end
      it "redirects to the support request show page" do
        valid_request
        expect(response).to redirect_to(support_request_path(SupportRequest.last))
      end
      it "sets a flash notice message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end
    context "with invalid attributes" do
      def invalid_request
        post :create, support_request: {email: "test@test.com",
                                        department: "sales",
                                        message: "some valid message",
                                        completed: "not done"}
      end
      it "does not create a new record in the database" do
        support_request_count_before = SupportRequest.count
        invalid_request
        support_request_count_after = SupportRequest.count
        expect(support_request_count_after - support_request_count_before).to eq(0)
      end
      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end
      it "sets a flash alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
    it "fetches all records and assigns them to @support_requests" do
      r1 = FactoryGirl.create(:support_request)
      r2 = FactoryGirl.create(:support_request)
      get :index
      expect(assigns(:support_requests)).to include(r1,r2)
    end
  end

  describe "#show" do
    before do
      support_request
      get :show, id: support_request.id
    end
    it "finds the object by id and sets it equal to @support_request" do
      expect(assigns(:support_request)).to eq(support_request)
    end
    it "renders the show template" do
      expect(response).to render_template(:show)
    end
  end

  describe "#edit" do
    before do
      support_request
      get :edit, id: support_request.id
    end
    it "finds a support request by id and sets it to @support_request instance variable" do
      expect(assigns(:support_request)).to eq(support_request)
    end
    it "renders the edit template" do
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    context "with valid attributes" do
      def valid_request
        patch :update, id: support_request.id, support_request: {name: "valid new name"}
      end
      it "updates the record in the database" do
        valid_request
        expect(support_request.reload.name).to eq("valid new name")
      end
      it "redirects to the support request show page when any attribute but completed is updated" do
        valid_request
        expect(response).to redirect_to(support_request_path(support_request))
      end
      it "redirects to the support requests page when completed is updated" do
        patch :update, id: support_request.id, support_request: {completed: "done"}
        expect(response).to redirect_to(support_requests_path)
      end
      it "sets a flash notice message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end
    context "with invalid attributes" do
      def invalid_request
        patch :update, id: support_request.id, support_request: {name: nil}
      end
      it "does not update the record in the database" do
        support_request_name_before = support_request.name
        invalid_request
        support_request_name_after = support_request.name
        expect(support_request_name_before).to eq(support_request_name_after)
      end
      it "renders the edit template" do
        invalid_request
        expect(response).to render_template(:edit)
      end
      it "sets a flash alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#destroy" do
    before do
      support_request
    end
    it "deletes the record in the database" do
      support_request_count_before = SupportRequest.count
      delete :destroy, id: support_request.id
      support_request_count_after = SupportRequest.count
      expect(support_request_count_before - support_request_count_after).to eq(1)
    end
    it "redirects to the support_requests page" do
      delete :destroy, id: support_request.id
      expect(response).to redirect_to(support_requests_path)
    end
    it "sets a flash alert message" do
      delete :destroy, id: support_request.id
      expect(flash[:alert]).to be
    end
  end

end
