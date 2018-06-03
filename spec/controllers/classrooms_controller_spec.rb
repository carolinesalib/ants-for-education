require 'rails_helper'

describe ClassroomsController do
  let(:school) { create(:school) }
  let(:course) { create(:course) }
  let(:serie) { create(:serie) }
  let!(:classrooms) { create_list(:classroom, 2, school_id: school.id, course_id: course.id, serie_id: serie.id) }

  describe 'GET #filtered_classrooms' do
    context 'when user is not authenticated' do
      before do
        get :filtered_classrooms
      end

      it 'returns http status 302' do
        expect(response).to have_http_status(:found)
      end
    end

    context 'when does not have filters' do
      login_user

      before do
        get :filtered_classrooms
      end

      it 'returns http status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns content type json' do
        expect(response.content_type).to eq('application/json')
      end

      it 'returns an empty json' do
        expect(response.body).to eq('{}')
      end
    end

    context 'when does not have classrooms with the filters' do
      login_user

      before do
        school = create(:school)
        course = create(:course)
        serie = create(:serie)

        get :filtered_classrooms, params: { school_id: school.id, course_id: course.id, serie_id: serie.id }
      end

      it 'returns http status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns content type json' do
        expect(response.content_type).to eq('application/json')
      end

      it 'returns an empty json' do
        expect(response.body).to eq('{}')
      end
    end

    context 'when have classrooms with the filters' do
      login_user

      before do
        get :filtered_classrooms, params: { school_id: school.id, course_id: course.id, serie_id: serie.id }
      end

      it 'returns http status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns content type json' do
        expect(response.content_type).to eq('application/json')
      end

      it 'returns an empty json' do
        expect(response.body).to eq(classrooms.to_json.to_s)
      end
    end
  end
end