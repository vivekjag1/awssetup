    #base image: 
        FROM python:3.12.2-slim 
        #set the home and working directory to be the app directory
        ENV HOME=/app
        ENV SQLALCHEMY_DATABASE_URI='REPLACE WITH YOUR PROD DATABASE URL'
        WORKDIR /app
        #move the requirements.txt text file into the container and install dependencies
        ADD ./requirements.txt ./requirements.txt
        RUN python -m venv venv
        RUN /bin/bash -c "source ./venv/bin/activate"
    
        RUN pip install --no-cache-dir -r requirements.txt 
        #copy all files into the app directory (inside the container)
        COPY . /app
            
        #set flask to run the production environment 
    
        ENV FLASK_ENV=production
        ENV PATH=/app/.local/bin:$PATH
        
        #expose the port
        EXPOSE 3001
            
        # When deployed, run db upgrade then run the server on port 3001.
        #TODO when you run the container map port 80 to 3001  
        CMD ["sh", "-c", "flask db upgrade && flask run --host=0.0.0.0 --port=3001"] 
