import PropTypes from 'prop-types';
import React from 'react';

export default class Dashboard extends React.Component {
  static propTypes = {
    records: PropTypes.array.isRequired,
  };

  /**
   * @param props - Comes from your rails view.
   * @param _railsContext - Comes from React on Rails
   */
  constructor(props, _railsContext) {
    super(props);
    this.state = {
      records: this.props.records
    };
  }

  render() {
    return (
      <div>
        <h3>
          Welcome to your dashboard!
        </h3>
        <hr />
        <div className='upload-drop-zone'>
           Drag and drop OR Click to Upload
           a Picture of a License Plate
        </div>

        <input type='file' name='record[s3_url]' id='s3-upload-image-input'/>
      </div>
    );
  }

  componentDidMount() {
    console.log('dashboard component is rendered')
  }
}
