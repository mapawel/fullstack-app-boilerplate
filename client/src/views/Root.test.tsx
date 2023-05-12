import { render, screen } from '@testing-library/react';
import Root from '../views/Root';

test('renders learn react link', () => {
    render(<Root />);
    const linkElement = screen.getByText(/React 18 Alpha/i);
    expect(linkElement).toBeInTheDocument();
});
