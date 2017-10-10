import React from 'react';
import PropTypes from 'prop-types';

export default class CardLineItem extends React.Component {
  static propTypes = {
    card: PropTypes.object.isRequired
  };

  constructor(props, _railsContext) {
    super(props);

    this.state = {
      card: props.card
    };
  }

  render() {
    return (
      <div className='card-line-item'>
        <img className='card-image' src={this.props.card._source.image_url}/>
        {/*
        <div className='card-details'>
          <div className='col-xs-4'>
            <div className='card-plate'>
              <label>Name</label> {this.props.card._source.name}
            </div>
          </div>
        </div>
        */}
      </div>
    );
  }
}
