import numpy as np
import datetime as dt

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func

from flask import Flask, jsonify
import json


#################################################
# Database Setup
#################################################
# engine = create_engine("secret")


rds_connection_string = "secret"
engine = create_engine(f'postgresql://{rds_connection_string}')


# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save reference to the table
uspc_class_all_mo = Base.classes.uspc_class_all


# Create our session (link) from Python to the DB
session = Session(engine)

#################################################
# Flask Setup
#################################################
app = Flask(__name__)


#################################################
# Flask Routes
#################################################

@app.route("/")
def welcome():
    """List all available api routes."""
    return (
        f"Available Routes:<br/>" # br line break
        f"/api/v1.0/uspc_class_all<br/>"
        # f"/api/v1.0/stations<br/>"
        # f"/api/v1.0/tobs<br/>"
        # f"/api/v1.0/<start>/<end>"
    )


@app.route("/api/v1.0/uspc_class_all")
def uspc_class_all():
    
    
    # Query all prcps in the last 12 months as I did in JupyterLab
    prcp = session.query(uspc_class_all_mo.uspc_class).all()
    # print(prcp) # This is a list of tuples
    # Convert list of tuples into a dictionary using dict()
    prcp_list = list(prcp)
    print(prcp)
    return json.dumps({"data": prcp_list} # This is a dictionary
)

if __name__ == '__main__':
    app.run()