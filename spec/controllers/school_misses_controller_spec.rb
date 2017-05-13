require 'rails_helper'
require 'helper_module_spec'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe SchoolMissesController, type: :controller do
  let(:valid_inputs) { { date: DateTime.now.to_date,
                  alumn_id: 1} }
  let(:invalid_inputs) { { date: "Mattimito",
                    alumn_id: 1} }


    describe "GET new" do
      before(:each) do
        loggin_principal
      end
      it "assigns a new SchoolMiss to @school_miss" do
        get :new, {}
        expect( assigns(:school_miss) ).to be_a_new SchoolMiss
      end
    end

    describe "POST create" do
      before(:each) do
        loggin_principal
        alumn = Alumn.create(name: "Michael Cera", phone:"61988885555",
                         address:"Rua Vida Casa 15,Taguatinga",
                         password: "12345678", gender:"M",
                         birth_date:"07/06/1988", registry:"123456",
                         parent_id: 1, shift:"matutino")
			  Alumn.current = alumn
      end
      describe "With valid params" do
        it "Creates a new school_miss" do
          expect {
            post :create, params: {school_miss: valid_inputs, alumn_id: Alumn.current.id}
          }.to change(SchoolMiss, :count).by 1
        end
        it "Assigns a new miss to @school_miss" do
            post :create, params: {school_miss: valid_inputs, alumn_id: Alumn.current.id}
            sm = assigns(:school_miss)
            expect(sm).to be_a SchoolMiss
            expect(sm).to be_persisted
        end
        it "redirects to @alumn.current page" do
          post :create, params: {school_miss: valid_inputs, alumn_id: Alumn.current.id}
          expect(response).to redirect_to alumn_path(Alumn.current)
        end
      end

      describe "with invalid params" do
        it "does not create a new School Miss" do
          expect {
              post :create, params: {school_miss: invalid_inputs, alumn_id: Alumn.current.id}
          }.to change(SchoolMiss, :count).by 0
        end
      end
    end

    describe "PUT update" do
      before(:each) do
        loggin_principal
        alumn = Alumn.create(name: "Michael Cera", phone:"61988885555",
                         address:"Rua Vida Casa 15,Taguatinga",
                         password: "12345678", gender:"M",
                         birth_date:"07/06/1988", registry:"123456",
                         parent_id: 1, shift:"matutino")
        Alumn.current = alumn
      end

      describe "With valid params" do
        it "Updates a school_miss" do
          current_date = DateTime.now
          @school_miss = SchoolMiss.create(date: current_date, alumn_id: Alumn.current.id)
          put :update, id: @school_miss.id, school_miss: valid_inputs
          @school_miss.reload
          expect(@school_miss.date).to eq(valid_inputs[:date])
        end
      end

      describe "with invalid params" do
        it "does not updates a school_miss" do
          current_date = DateTime.now
          @school_miss = SchoolMiss.create(date: current_date, alumn_id: Alumn.current.id)
          put :update, id: @school_miss.id, school_miss: invalid_inputs, alumn_id: Alumn.current.id
          @school_miss.reload
          expect(@school_miss.date).not_to eq(invalid_inputs[:date])
        end
      end
    end

    describe "POST destroy" do
      before(:each) do
        loggin_principal
        alumn = Alumn.create(name: "Michael Cera", phone:"61988885555",
                         address:"Rua Vida Casa 15,Taguatinga",
                         password: "12345678", gender:"M",
                         birth_date:"07/06/1988", registry:"123456",
                         parent_id: 1, shift:"matutino")
        Alumn.current = alumn
      end
      describe "With valid params" do
        it "Destroys a school miss" do
          current_date = DateTime.now
          school_miss = SchoolMiss.create(date: current_date, alumn_id: Alumn.current.id)
          expect {
            post :destroy, params: {id: school_miss.id}
          }.to change(SchoolMiss, :count).by -1
        end
      end
    end
end
