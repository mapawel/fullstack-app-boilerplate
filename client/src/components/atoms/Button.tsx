import { MouseEventHandler, FC } from 'react';

interface Props {
    onClick: MouseEventHandler<HTMLButtonElement>;
}

const Button: FC<Props> = ({ onClick }): JSX.Element => (
    <button onClick={onClick}>Button</button>
);
export default Button;
