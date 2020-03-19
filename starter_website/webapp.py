from flask import Flask, render_template
from flask import request, redirect
from db_connector.db_connector import connect_to_database, execute_query

# create the web application
webapp = Flask(__name__)


@webapp.route('/')
def home():
    return render_template('home.html');


@webapp.route("/about_us")
def about_us():
    return render_template("about_us.html")


@webapp.route('/browse_students')
def browse_students():
    print("Fetching and rendering students web page")
    db_connection = connect_to_database()
    query = "SELECT first_name, last_name, age, id, avatar_link from students;"
    result = execute_query(db_connection, query).fetchall();
    print(result)
    return render_template('student_browse.html', rows=result)


@webapp.route('/add_new_student', methods=['POST','GET'])
def add_new_student():
    db_connection = connect_to_database()
    if request.method == 'GET':
        query = 'SELECT first_name, last_name, age, id, avatar_link from students'
        result = execute_query(db_connection, query).fetchall();
        print(result)
        return render_template('student_add_new.html', students=result)

    elif request.method == 'POST':
        print("Add new student!");
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        age = request.form['age']
        avatar_link = request.form['avatar_link']

        query = 'INSERT INTO students (first_name, last_name, age, avatar_link) VALUES (%s,%s,%s,%s)'
        data = (first_name, last_name, age, avatar_link)
        execute_query(db_connection, query, data)
        return ('Student added!');


# display update form and process any updates, using the same function
@webapp.route('/update_student/<int:id>', methods=['POST', 'GET'])
def update_student(id):
    db_connection = connect_to_database()
    # display existing data
    if request.method == 'GET':
        student_query = 'SELECT id, first_name, last_name, age from students WHERE id = %s' % (id)
        student_result = execute_query(db_connection, student_query).fetchone()

        if student_result is None:
            return "No such student found in the database!"

        #TODO: update other tables too

        return render_template('student_update.html', students=student_result)

    elif request.method == 'POST':
        print("Update student!");
        student_id = request.form['student_id']
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        age = request.form['age']

        print(request.form);

        query = "UPDATE students SET first_name = %s, last_name = %s, age = %s  WHERE id = %s"
        data = (first_name, last_name, age, student_id)
        result = execute_query(db_connection, query, data)
        print(str(result.rowcount) + " row(s) updated");
        return redirect('/browse_students')


@webapp.route('/delete_student/<int:id>')
def delete_student(id):
    '''deletes a person with the given id'''
    db_connection = connect_to_database()
    query = "DELETE FROM students WHERE id = %s"
    data = (id,)

    result = execute_query(db_connection, query, data)
    print(str(result.rowcount) + " row(s) deleted");
    return redirect('browse_students')


@webapp.route('/browse_courses')
def browse_courses():
    print("Fetching and rendering students web page")
    db_connection = connect_to_database()
    query = """
    SELECT classes.id, name, description, GROUP_CONCAT(first_name, " ", last_name SEPARATOR ", ") AS student_names from classes
    INNER JOIN enrollments ON classes.id = enrollments.class_id
    INNER JOIN students ON enrollments.student_id = students.id
    GROUP BY classes.id
    ORDER BY classes.id;
    """
    result = execute_query(db_connection, query).fetchall();
    print(result)
    return render_template('course_browse.html', rows=result)


@webapp.route('/browse_grades_start')
def browse_grades_start():
    print("Fetching and rendering browse grades dropdown list")
    db_connection = connect_to_database()
    course_query = """
    SELECT id, name FROM classes
    ORDER BY id;
    """
    course_result = execute_query(db_connection, course_query).fetchall()
    print(course_result)
    return render_template('grade_browse_start.html', course=course_result)


@webapp.route('/browse_grades', methods=['GET', 'POST'])
def browse_grades():
    if request.method == 'POST':
        id = str(request.form.get('comp_select'))
        print(id)
        print("Fetching and rendering grades web page")
        db_connection = connect_to_database()
        # display existing data
        grade_query = 'SELECT name, first_name, last_name, grade, grade_report.id FROM grade_report INNER JOIN classes ON grade_report.class_id = classes.id WHERE class_id = %s ORDER BY grade DESC;' %(id)
        grade_result = execute_query(db_connection, grade_query).fetchall();
        print(grade_result)
        if grade_result is None:
            return "No such course found in the database!"
        return render_template('grade_browse.html', rows=grade_result)


    # query = """
    # SELECT name, first_name, last_name, grade, grade_report.id FROM grade_report
    # INNER JOIN classes ON grade_report.class_id = classes.id
    # WHERE name = 'Classic Music Theory'
    # ORDER BY grade DESC;
    # """
    # result = execute_query(db_connection, query).fetchall();
    # print(result)
    # return render_template('grade_browse.html', rows=result)


# display update form and process any updates, using the same function
@webapp.route('/update_grade/<string:id>', methods=['POST', 'GET'])
def update_grade(id):
    db_connection = connect_to_database()
    # display existing data
    if request.method == 'GET':
        grade_query = "SELECT id, class_name, first_name, last_name, grade from grade_report WHERE id = '%s'" % (id)
        grade_result = execute_query(db_connection, grade_query).fetchone()

        if grade_result is None:
            return "No such grade for this student and course found in the database!"
        return render_template('grade_update.html', grades=grade_result)

    elif request.method == 'POST':
        print("Update grade!");
        grade_id = request.form['grade_id']
        grade = request.form['grade']

        print(request.form);

        query = "UPDATE grade_report SET grade = %s WHERE id = %s"
        data = (grade, grade_id)
        result = execute_query(db_connection, query, data)
        print(str(result.rowcount) + " row(s) updated");
        return redirect('/browse_grades_start')
