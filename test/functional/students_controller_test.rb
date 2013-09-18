require 'test_helper'

class StudentsControllerTest < ActionController::TestCase
  setup do
    @student = students(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:students)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student" do
    assert_difference('Student.count') do
      post :create, student: { address_1: @student.address_1, address_2: @student.address_2, city: @student.city, classification: @student.classification, cum_institution_gpa: @student.cum_institution_gpa, cum_overall_gpa_hrs: @student.cum_overall_gpa_hrs, degree_candidate: @student.degree_candidate, email: @student.email, emailed: @student.emailed, first_name: @student.first_name, first_term: @student.first_term, last_name: @student.last_name, major: @student.major, phone_number: @student.phone_number, postal_code: @student.postal_code, state: @student.state, status: @student.status, term_institution_gpa: @student.term_institution_gpa, term_institution_gpa_hrs: @student.term_institution_gpa_hrs, uin: @student.uin, var_cum_qpts: @student.var_cum_qpts, var_term_qpts: @student.var_term_qpts }
    end

    assert_redirected_to student_path(assigns(:student))
  end

  test "should show student" do
    get :show, id: @student
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @student
    assert_response :success
  end

  test "should update student" do
    put :update, id: @student, student: { address_1: @student.address_1, address_2: @student.address_2, city: @student.city, classification: @student.classification, cum_institution_gpa: @student.cum_institution_gpa, cum_overall_gpa_hrs: @student.cum_overall_gpa_hrs, degree_candidate: @student.degree_candidate, email: @student.email, emailed: @student.emailed, first_name: @student.first_name, first_term: @student.first_term, last_name: @student.last_name, major: @student.major, phone_number: @student.phone_number, postal_code: @student.postal_code, state: @student.state, status: @student.status, term_institution_gpa: @student.term_institution_gpa, term_institution_gpa_hrs: @student.term_institution_gpa_hrs, uin: @student.uin, var_cum_qpts: @student.var_cum_qpts, var_term_qpts: @student.var_term_qpts }
    assert_redirected_to student_path(assigns(:student))
  end

  test "should destroy student" do
    assert_difference('Student.count', -1) do
      delete :destroy, id: @student
    end

    assert_redirected_to students_path
  end
end
