from flask import Flask, render_template, request, redirect, url_for, session
from datetime import datetime

app = Flask(__name__)
app.secret_key = 'your_secret_key'  # Required for session management

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        # Store the user's name and session start time
        session['username'] = request.form['name']
        session['start_time'] = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        return redirect(url_for('greeting'))
    return render_template('index.html')

@app.route('/greeting')
def greeting():
    if 'username' not in session:
        return redirect(url_for('index'))
    return render_template('greeting.html', username=session['username'], start_time=session['start_time'])

@app.route('/logout')
def logout():
    if 'username' not in session:
        return redirect(url_for('index'))
    
    # Calculate usage duration
    start_time = datetime.strptime(session['start_time'], '%Y-%m-%d %H:%M:%S')
    end_time = datetime.now()
    duration = end_time - start_time
    
    # Clear the session
    session.pop('username', None)
    session.pop('start_time', None)
    
    return render_template('logout.html', duration=duration)

if __name__ == '__main__':
    app.run(debug=True)